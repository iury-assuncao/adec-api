import { Injectable } from '@nestjs/common';
import { Prisma } from '@prisma-client';
import { PrismaService } from '../prisma.service';
import { CreateUserDto } from '@/modules/users/dto/create-user.dto';

@Injectable()
export class UsersRepository {
  constructor(private readonly prismaService: PrismaService) {}

  create(createDto: Prisma.UserCreateArgs) {
    return this.prismaService.user.create({ data: createDto });
  }

  findUnique(findUniqueDto: Prisma.UserFindUniqueArgs) {
    return this.prismaService.user.findUnique(findUniqueDto);
  }
}
